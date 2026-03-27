package savedsearches

import (
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/mock"
)

// MockSavedSearchDB implements SavedSearchDB interface for testing.
type MockSavedSearchDB struct {
	mock.Mock
}

func (m *MockSavedSearchDB) GetSavedSearches(userId int) []*db.SavedSearch {
	args := m.Called(userId)
	return args.Get(0).([]*db.SavedSearch)
}

func (m *MockSavedSearchDB) GetSavedSearchById(savedSearchId int) *db.SavedSearch {
	args := m.Called(savedSearchId)
	if args.Get(0) == nil {
		return nil
	}
	return args.Get(0).(*db.SavedSearch)
}

func (m *MockSavedSearchDB) CreateSavedSearch(savedSearch *db.SavedSearch) (int, error) {
	args := m.Called(savedSearch)
	return args.Int(0), args.Error(1)
}

func (m *MockSavedSearchDB) DeleteSavedSearchById(id int) error {
	args := m.Called(id)
	return args.Error(0)
}

func (m *MockSavedSearchDB) GetEligibilitiesByIDs(ids []int) []*db.Eligibility {
	args := m.Called(ids)
	return args.Get(0).([]*db.Eligibility)
}

func (m *MockSavedSearchDB) GetEligibilitiesByNames(names []string) []*db.Eligibility {
	args := m.Called(names)
	return args.Get(0).([]*db.Eligibility)
}

func (m *MockSavedSearchDB) GetCategoriesByIDs(ids []int) []*db.Category {
	args := m.Called(ids)
	return args.Get(0).([]*db.Category)
}

func (m *MockSavedSearchDB) GetCategoriesByNames(names []string) []*db.Category {
	args := m.Called(names)
	return args.Get(0).([]*db.Category)
}
