package resources

import (
	"fmt"
	"github.com/DATA-DOG/go-sqlmock"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/require"
	"net/http"
	"net/http/httptest"
	"testing"
)

type certificationIndex struct {
	saved string
	err   error
}

func (i *certificationIndex) SaveObject(id string, _ interface{}) error { i.saved = id; return i.err }
func (i *certificationIndex) DeleteObject(string) error                 { return i.err }
func TestCertificationReindexesAfterWrite(t *testing.T) {
	for _, fail := range []bool{false, true} {
		database, mock, err := sqlmock.New()
		require.NoError(t, err)
		mock.ExpectExec("UPDATE public.resources").WithArgs(7).WillReturnResult(sqlmock.NewResult(0, 1))
		mock.ExpectQuery("SELECT json_build_object").WithArgs(7).WillReturnRows(sqlmock.NewRows([]string{"json"}).AddRow(`{"resource":{"status":1,"certified":true}}`))
		index := &certificationIndex{}
		status := 200
		if fail {
			index.err = fmt.Errorf("index unavailable")
			status = 500
		}
		w := httptest.NewRecorder()
		NewWithDependencies(&db.Manager{DB: database}, index).Certify(w, requestWithResourceID(http.MethodPost, "/api/resources/7/certify", "7"))
		require.Equal(t, status, w.Code)
		require.Equal(t, "resource_7", index.saved)
		require.NoError(t, mock.ExpectationsWereMet())
		database.Close()
	}
}
