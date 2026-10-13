package db

import "database/sql"

type TextingRecipient struct {
	Id            int
	RecipientName sql.NullString
	PhoneNumber   string
}

const textingRecipientByPhoneNumberSql = `
SELECT id, recipient_name, phone_number
FROM public.texting_recipients
WHERE phone_number = $1
`

const createTextingRecipientSql = `
INSERT INTO public.texting_recipients (recipient_name, phone_number, created_at, updated_at)
VALUES ($1, $2, NOW(), NOW())
RETURNING id
`

const updateTextingRecipientSql = `
UPDATE public.texting_recipients
SET recipient_name = $2, updated_at = NOW()
WHERE id = $1
`

const createTextingSql = `
INSERT INTO public.textings (texting_recipient_id, service_id, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, NOW(), NOW())
`

func (m *Manager) SaveTexting(recipientName, phoneNumber string, serviceId, resourceId *int) error {
	tx, err := m.DB.Begin()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	var recipientId int
	var existingRecipient TextingRecipient
	err = tx.QueryRow(textingRecipientByPhoneNumberSql, phoneNumber).Scan(
		&existingRecipient.Id,
		&existingRecipient.RecipientName,
		&existingRecipient.PhoneNumber,
	)
	if err == sql.ErrNoRows {
		err = tx.QueryRow(createTextingRecipientSql, recipientName, phoneNumber).Scan(&recipientId)
		if err != nil {
			return err
		}
	} else if err != nil {
		return err
	} else {
		recipientId = existingRecipient.Id
		_, err = tx.Exec(updateTextingRecipientSql, recipientId, recipientName)
		if err != nil {
			return err
		}
	}

	_, err = tx.Exec(createTextingSql, recipientId, nullableInt(serviceId), nullableInt(resourceId))
	if err != nil {
		return err
	}

	return tx.Commit()
}

func nullableInt(value *int) interface{} {
	if value == nil {
		return nil
	}
	return *value
}
