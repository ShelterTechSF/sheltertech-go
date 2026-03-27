package bookmarks

import (
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/stretchr/testify/mock"
)

// MockBookmarkDB implements BookmarkDB interface for testing.
type MockBookmarkDB struct {
	mock.Mock
}

func (m *MockBookmarkDB) GetBookmarksByUserID(userId int) ([]*db.Bookmark, error) {
	args := m.Called(userId)
	return args.Get(0).([]*db.Bookmark), args.Error(1)
}

func (m *MockBookmarkDB) GetBookmarkByID(bookmarkId int) (*db.Bookmark, error) {
	args := m.Called(bookmarkId)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*db.Bookmark), args.Error(1)
}

func (m *MockBookmarkDB) SubmitBookmark(bookmark *db.Bookmark) error {
	args := m.Called(bookmark)
	return args.Error(0)
}

func (m *MockBookmarkDB) UpdateBookmark(bookmark *db.Bookmark) error {
	args := m.Called(bookmark)
	return args.Error(0)
}

func (m *MockBookmarkDB) DeleteBookmarkByID(bookmarkId int) error {
	args := m.Called(bookmarkId)
	return args.Error(0)
}
