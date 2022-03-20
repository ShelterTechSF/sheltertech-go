package main

import (
	"net/http"

	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/db"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/spf13/viper"
)

func main() {

	viper.AutomaticEnv()
	dbUser := viper.GetString("DB_USER")
	dbHost := viper.GetString("DB_HOST")
	dbPort := viper.GetString("DB_PORT")
	dbName := viper.GetString("DB_NAME")
	dbPass := viper.GetString("DB_PASS")

	dbManager := db.New(dbHost, dbPort, dbName, dbUser, dbPass)
	categoriesManager := categories.New(dbManager)

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	r.Get("/api/categories", categoriesManager.Get)
	r.Get("/api/categories/{id}", categoriesManager.GetByID)
	r.Get("/api/categories/subcategories/{id}", categoriesManager.GetSubCategoriesByID)
	r.Get("/api/categories/featured", categoriesManager.GetByFeatured)
	http.ListenAndServe(":3001", r)
}
