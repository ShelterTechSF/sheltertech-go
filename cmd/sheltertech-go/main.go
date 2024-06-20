package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/sheltertechsf/sheltertech-go/docs"
	"github.com/sheltertechsf/sheltertech-go/internal/categories"
	"github.com/sheltertechsf/sheltertech-go/internal/changerequest"
	"github.com/sheltertechsf/sheltertech-go/internal/db"
	"github.com/sheltertechsf/sheltertech-go/internal/folders"
	"github.com/sheltertechsf/sheltertech-go/internal/resources"
	"github.com/sheltertechsf/sheltertech-go/internal/services"
	"github.com/sheltertechsf/sheltertech-go/internal/users"
	"github.com/sheltertechsf/sheltertech-go/internal/bookmarks"

	"github.com/MicahParks/keyfunc/v3"
	"github.com/getsentry/sentry-go"
	sentryhttp "github.com/getsentry/sentry-go/http"
	"github.com/gin-gonic/gin"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/spf13/viper"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
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
	serveDocs := viper.GetBool("SERVE_DOCS")
	auth0Domain := viper.GetString("AUTH0_DOMAIN")

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

	r := chi.NewRouter()
	r.Use(prometheusMiddleware)
	r.Use(middleware.Logger)
	r.Use(sentryHandler.Handle)

	r.Get("/api/categories", categoriesManager.Get)
	r.Get("/api/categories/{id}", categoriesManager.GetByID)
	r.Get("/api/categories/subcategories/{id}", categoriesManager.GetSubCategoriesByID)
	r.Get("/api/categories/featured", categoriesManager.GetByFeatured)
	r.Get("/api/categories/counts", categoriesManager.GetCategoryCounts)

	// no user auth in folders yet
	r.Get("/api/folders", foldersManager.Get)
	r.Post("/api/folders", foldersManager.Post)
	r.Get("/api/folders/{id}", foldersManager.GetByID)
	r.Put("/api/folders/{id}", foldersManager.Put)
	r.Delete("/api/folders/{id}", foldersManager.Delete)

	r.Post("/api/services/{id}/change_request", changeRequestManager.Submit)
	r.Get("/api/services/{id}", servicesManager.GetByID)
	r.Get("/api/resources/{id}", resourcesManager.GetByID)
	r.Get("/api/users/current", usersManager.GetCurrent)

	r.Get("/metrics", promhttp.Handler().ServeHTTP)

	r.Post("/api/bookmarks", bookmarksManager.Submit)
	r.Delete("/api/bookmarks/{id}", bookmarksManager.DeleteByID)

	docs.SwaggerInfo.Title = "Swagger Example API"
	docs.SwaggerInfo.Description = "This is a sample server Petstore server."
	docs.SwaggerInfo.Version = "1.0"
	docs.SwaggerInfo.Host = "petstore.swagger.io"
	docs.SwaggerInfo.BasePath = "/v2"
	docs.SwaggerInfo.Schemes = []string{"http", "https"}

	if serveDocs {
		gin.SetMode(gin.ReleaseMode)
		rg := gin.Default()
		rg.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
		go rg.Run(":3002")
	}

	http.ListenAndServe(":3001", r)
}
