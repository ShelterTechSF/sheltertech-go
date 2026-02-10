package db

type FieldChange struct {
	Id              int
	FieldName       string
	FieldValue      string
	ChangeRequestId int
}

const insertFieldChangeSql = `
INSERT INTO public.field_changes (field_name, field_value, change_request_id)
VALUES ($1, $2, $3)`

func (m *Manager) InsertFieldChange(fieldChange FieldChange) error {
	_, err := m.DB.Exec(
		insertFieldChangeSql,
		fieldChange.FieldName,
		fieldChange.FieldValue,
		fieldChange.ChangeRequestId,
	)

	return err
}
