package db

import (
	"database/sql"
	"errors"
	"fmt"
	"strings"
)

var ErrServiceChangeRequestInvalidServiceID = errors.New("invalid service ID")

type ServiceChangeRequestServiceFieldInput struct {
	FieldName  string
	FieldValue interface{}
}

type ServiceChangeRequestCategoryAssociationInput struct {
	ID          int
	FeatureRank *int
}

type ServiceChangeRequestAssociationInputs struct {
	Categories    *[]ServiceChangeRequestCategoryAssociationInput
	Eligibilities *[]int
}

const serviceChangeRequestResourceIDByServiceIDSql = `
SELECT resource_id
FROM public.services
WHERE id = $1
`

const serviceChangeRequestDeleteCategoriesSql = `
DELETE FROM public.categories_services
WHERE service_id = $1`

const serviceChangeRequestInsertCategorySql = `
INSERT INTO public.categories_services (service_id, category_id, feature_rank)
VALUES ($1, $2, $3)`

const serviceChangeRequestDeleteEligibilitiesSql = `
DELETE FROM public.eligibilities_services
WHERE service_id = $1`

const serviceChangeRequestInsertEligibilitySql = `
INSERT INTO public.eligibilities_services (service_id, eligibility_id)
VALUES ($1, $2)`

func (m *Manager) UpdateServiceChangeRequest(
	serviceID int,
	serviceFields []ServiceChangeRequestServiceFieldInput,
	associations ServiceChangeRequestAssociationInputs,
	fieldChanges []ServiceChangeRequestServiceFieldInput,
) (*int, error) {
	tx, err := m.DB.Begin()
	if err != nil {
		return nil, err
	}
	defer tx.Rollback()

	var resourceID sql.NullInt32
	err = tx.QueryRow(serviceChangeRequestResourceIDByServiceIDSql, serviceID).Scan(&resourceID)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, ErrServiceChangeRequestInvalidServiceID
		}
		return nil, err
	}

	if len(serviceFields) != 0 {
		updateServiceSQL, args := serviceChangeRequestBuildServiceUpdateSQL(serviceID, serviceFields)
		_, err = tx.Exec(updateServiceSQL, args...)
		if err != nil {
			return nil, err
		}
	}

	if associations.Categories != nil {
		_, err = tx.Exec(serviceChangeRequestDeleteCategoriesSql, serviceID)
		if err != nil {
			return nil, err
		}
		for _, category := range *associations.Categories {
			var featureRank interface{}
			if category.FeatureRank != nil {
				featureRank = *category.FeatureRank
			}
			_, err = tx.Exec(serviceChangeRequestInsertCategorySql, serviceID, category.ID, featureRank)
			if err != nil {
				return nil, err
			}
		}
	}

	if associations.Eligibilities != nil {
		_, err = tx.Exec(serviceChangeRequestDeleteEligibilitiesSql, serviceID)
		if err != nil {
			return nil, err
		}
		for _, eligibilityID := range *associations.Eligibilities {
			_, err = tx.Exec(serviceChangeRequestInsertEligibilitySql, serviceID, eligibilityID)
			if err != nil {
				return nil, err
			}
		}
	}

	var resourceIDArg interface{}
	if resourceID.Valid {
		resourceIDArg = int(resourceID.Int32)
	}

	var changeRequestID int
	err = tx.QueryRow(
		insertChangeRequestSql,
		"ServiceChangeRequest",
		serviceID,
		StatusPending,
		ActionEdit,
		resourceIDArg,
	).Scan(&changeRequestID)
	if err != nil {
		return nil, err
	}

	for _, fieldChange := range fieldChanges {
		_, err = tx.Exec(insertFieldChangeSql, fieldChange.FieldName, fieldChange.FieldValue, changeRequestID)
		if err != nil {
			return nil, err
		}
	}

	err = tx.Commit()
	if err != nil {
		return nil, err
	}

	return &changeRequestID, nil
}

func serviceChangeRequestBuildServiceUpdateSQL(serviceID int, fields []ServiceChangeRequestServiceFieldInput) (string, []interface{}) {
	setParts := make([]string, 0, len(fields)+1)
	args := make([]interface{}, 0, len(fields)+1)
	for index, field := range fields {
		setParts = append(setParts, fmt.Sprintf("%s=$%d", field.FieldName, index+1))
		args = append(args, field.FieldValue)
	}
	setParts = append(setParts, "updated_at=now()")
	args = append(args, serviceID)

	return fmt.Sprintf(
		"UPDATE public.services SET %s WHERE id=$%d",
		strings.Join(setParts, ", "),
		len(args),
	), args
}
