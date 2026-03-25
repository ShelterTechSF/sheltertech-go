package folders

import (
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/mock"
)

// MockFolderDB implements FolderDB interface for testing.
type MockFolderDB struct {
	mock.Mock
}

func (m *MockFolderDB) GetFolders(userId int) []*db.Folder {
	args := m.Called(userId)
	return args.Get(0).([]*db.Folder)
}

func (m *MockFolderDB) GetFolderById(folderId int) *db.Folder {
	args := m.Called(folderId)
	if args.Get(0) == nil {
		return nil
	}
	return args.Get(0).(*db.Folder)
}

func (m *MockFolderDB) CreateFolder(folder *db.Folder) (int, error) {
	args := m.Called(folder)
	return args.Int(0), args.Error(1)
}

func (m *MockFolderDB) UpdateFolder(folder *db.Folder) error {
	args := m.Called(folder)
	return args.Error(0)
}

func (m *MockFolderDB) DeleteFolderById(folderId int) error {
	args := m.Called(folderId)
	return args.Error(0)
}
