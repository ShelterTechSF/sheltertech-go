package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/sheltertechsf/sheltertech-go/docs"
	"github.com/sheltertechsf/sheltertech-go/internal/auth"
	"github.com/sheltertechsf/sheltertech-go/internal/bookmarks"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/sheltertechsf/sheltertech-go/internal/datathon"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/eligibilities"
	"github.com/sheltertechsf/sheltertech-go/internal/folders"
	newsarticles "github.com/sheltertechsf/sheltertech-go/internal/news_articles"
	"github.com/sheltertechsf/sheltertech-go/internal/phones"
	"github.com/sheltertechsf/sheltertech-go/internal/resources"
	"github.com/sheltertechsf/sheltertech-go/internal/savedsearches"
	"github.com/sheltertechsf/sheltertech-go/internal/services"
	"github.com/sheltertechsf/sheltertech-go/internal/users"

	"github.com/MicahParks/keyfunc/v3"
	"github.com/getsentry/sentry-go"
	sentryhttp "github.com/getsentry/sentry-go/http"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/spf13/viper"
	httpSwagger "github.com/swaggo/http-swagger"
)

//	@title			Swagger Example API
//	@version		1.0
//	@description	This is a sample server celler server.
//	@termsOfService	http://swagger.io/terms/

//	@contact.name	API Support
//	@contact.url	http://www.swagger.io/support
//	@contact.email	support@swagger.io

//	@license.name	Apache 2.0
//	@license.url	http://www.apache.org/licenses/LICENSE-2.0.html

//	@host		localhost:8080
//	@BasePath	/api/v1

//	@securityDefinitions.basic	BasicAuth

// @externalDocs.description	OpenAPI
// @externalDocs.url			https://swagger.io/resources/open-api/
func main() {

	viper.AutomaticEnv()
	dbUser := viper.GetString("DB_USER")
	dbHost := viper.GetString("DB_HOST")
	dbPort := viper.GetString("DB_PORT")
	dbName := viper.GetString("DB_NAME")
	dbPass := viper.GetString("DB_PASS")
	auth0Domain := viper.GetString("AUTH0_DOMAIN")
	enableJwtVerification := viper.GetBool("ENABLE_JWT_VERIFICATION")
	var jwtKeyfunc keyfunc.Keyfunc
	if auth0Domain != "" {
		jwksUrl := "https://" + auth0Domain + "/.well-known/jwks.json"
		var err error
		jwtKeyfunc, err = keyfunc.NewDefault([]string{jwksUrl})
		if err != nil {
			log.Fatalf("Failed to create keyfunc for %q.\nError: %s", jwksUrl, err)
		}
	}

	dbManager := db.New(dbHost, dbPort, dbName, dbUser, dbPass)
	categoriesManager := categories.New(dbManager)
	changeRequestManager := changerequest.New(dbManager)
	foldersManager := folders.New(dbManager)
	servicesManager := services.New(dbManager)
	resourcesManager := resources.New(dbManager)
	usersManager := users.New(dbManager, jwtKeyfunc)
	bookmarksManager := bookmarks.New(dbManager)
	savedSearchesManager := savedsearches.New(dbManager)
	datathonManager := datathon.New(dbManager)
	newsArticlesManager := newsarticles.New(dbManager)

	eligibilityManager := eligibilities.New((dbManager))
	phonesManager := phones.New(dbManager)
	if err := sentry.Init(sentry.ClientOptions{
		Dsn:           "https://33395501c62bebff33ef58295a800bb3@o191099.ingest.sentry.io/4505843152846848",
		EnableTracing: true,
		// Set TracesSampleRate to 1.0 to capture 100%
		// of transactions for performance monitoring.
		// We recommend adjusting this value in production,
		TracesSampleRate: 1.0,
	}); err != nil {
		fmt.Printf("Sentry initialization failed: %v", err)
	}

	sentryHandler := sentryhttp.New(sentryhttp.Options{})
	docs.SwaggerInfo.Title = "Swagger Example API"
	docs.SwaggerInfo.Description = "This is a sample server Petstore server."
	docs.SwaggerInfo.Version = "1.0"
	docs.SwaggerInfo.Host = "petstore.swagger.io"
	docs.SwaggerInfo.BasePath = "/v2"
	docs.SwaggerInfo.Schemes = []string{"http", "https"}

	r := chi.NewRouter()
	r.Use(prometheusMiddleware)
	r.Use(middleware.Logger)
	r.Use(sentryHandler.Handle)

	r.Group(func(r chi.Router) {
		if enableJwtVerification {
			r.Use(auth.EnsureValidToken())
		}
		r.Get("/api/folders", foldersManager.Get)
		r.Post("/api/folders", foldersManager.Post)
		r.Get("/api/folders/{id}", foldersManager.GetByID)
		r.Put("/api/folders/{id}", foldersManager.Put)
		r.Delete("/api/folders/{id}", foldersManager.Delete)

		r.Get("/api/bookmarks", bookmarksManager.Get)
		r.Get("/api/bookmarks/{id}", bookmarksManager.GetByID)
		r.Post("/api/bookmarks", bookmarksManager.Submit)
		r.Put("/api/bookmarks/{id}", bookmarksManager.Update)
		r.Delete("/api/bookmarks/{id}", bookmarksManager.DeleteByID)

		r.Get("/api/saved_searches", savedSearchesManager.Get)
		r.Post("/api/saved_searches", savedSearchesManager.Post)
		r.Get("/api/saved_searches/{id}", savedSearchesManager.GetByID)
		// r.Put("/api/saved_searches/{id}", savedSearchesManager.Put)
		r.Delete("/api/saved_searches/{id}", savedSearchesManager.Delete)

		r.Delete("/api/phones/{id}", phonesManager.Delete)
	})

	r.Group(func(r chi.Router) {
		r.Mount("/api/swagger", httpSwagger.WrapHandler)
		r.Get("/api/categories", categoriesManager.Get)
		r.Get("/api/categories/{id}", categoriesManager.GetByID)
		r.Get("/api/categories/subcategories/{id}", categoriesManager.GetSubCategoriesByID)
		r.Get("/api/categories/featured", categoriesManager.GetByFeatured)
		r.Get("/api/categories/counts", categoriesManager.GetCategoryCounts)

		r.Post("/api/services/{id}/change_request", changeRequestManager.Submit)
		r.Get("/api/services/{id}", servicesManager.GetByID)
		r.Get("/api/resources/{id}", resourcesManager.GetByID)
		r.Get("/api/resources/count", resourcesManager.GetCount)
		r.Get("/api/users/current", usersManager.GetCurrent)
		r.Get("/api/datathon/content_curation_dataset", datathonManager.GetContentCurationDataset)
		r.Get("/api/datathon/datathon_dataset", datathonManager.GetDatathonDataset)
		r.Get("/metrics", promhttp.Handler().ServeHTTP)

		r.Post("/api/news_articles", newsArticlesManager.Create)
		r.Get("/api/news_articles", newsArticlesManager.Get)
		r.Put("/api/news_articles/{id}", newsArticlesManager.Update)
		r.Delete("/api/news_articles/{id}", newsArticlesManager.Delete)
		r.Get("/api/eligibilities", eligibilityManager.Get)
		r.Get("/api/eligibilities/{id}", eligibilityManager.GetEligibilityById)
		r.Put("/api/eligibilities/{id}", eligibilityManager.UpdateEligibilityById)
		r.Get("/api/eligibilities/featured", eligibilityManager.GetFeaturedEligibilities)
		r.Get("/api/eligibilities/subeligibilities", eligibilityManager.GetSubEligibilities)

	})

	http.ListenAndServe(":3001", r)
}

func setIntegrationTestEnv() {
	// Only set defaults if environment variables are not already set
	if !viper.IsSet("DB_USER") {
		viper.SetDefault("DB_USER", "postgres")
	}
	if !viper.IsSet("DB_HOST") {
		viper.SetDefault("DB_HOST", "localhost")
	}
	if !viper.IsSet("DB_PORT") {
		viper.SetDefault("DB_PORT", "5432")
	}
	if !viper.IsSet("DB_NAME") {
		viper.SetDefault("DB_NAME", "askdarcel_development")
	}
	if !viper.IsSet("DB_PASS") {
		viper.SetDefault("DB_PASS", "")
	}
	if !viper.IsSet("AUTH0_DOMAIN") {
		viper.SetDefault("AUTH0_DOMAIN", "login.sfserviceguide.org")
	}
}
