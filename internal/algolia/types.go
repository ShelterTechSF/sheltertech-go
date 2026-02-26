package algolia

// ResourceRecord represents a resource in the Algolia search index.
type ResourceRecord struct {
	ObjectID    string          `json:"objectID"`
	Type        string          `json:"type"`
	ID          int             `json:"id"`
	Name        string          `json:"name"`
	AlternateName string        `json:"alternate_name,omitempty"`
	LongDescription string     `json:"long_description,omitempty"`
	ShortDescription string    `json:"short_description,omitempty"`
	Website     string          `json:"website,omitempty"`
	Email       string          `json:"email,omitempty"`
	Status      string          `json:"status"`
	Certified   bool            `json:"certified"`
	Featured    bool            `json:"featured"`
	VerifiedAt  string          `json:"verified_at,omitempty"`
	IsMohcdFunded bool          `json:"is_mohcd_funded"`
	GeoLoc      *GeoLoc         `json:"_geoloc,omitempty"`
	Addresses   []IndexAddress  `json:"addresses"`
	Schedule    *IndexSchedule  `json:"schedule,omitempty"`
	OpenTimes   []IndexOpenTime `json:"open_times"`
	Categories  []IndexCategory `json:"categories"`
	Notes       []IndexNote     `json:"notes"`
	Phones      []IndexPhone    `json:"phones"`
	ServiceNames []string       `json:"service_names"`
}

// ServiceRecord represents a service in the Algolia search index.
type ServiceRecord struct {
	ObjectID    string          `json:"objectID"`
	Type        string          `json:"type"`
	ID          int             `json:"id"`
	Name        string          `json:"name"`
	AlternateName string        `json:"alternate_name,omitempty"`
	LongDescription string     `json:"long_description,omitempty"`
	ShortDescription string    `json:"short_description,omitempty"`
	Website     string          `json:"url,omitempty"`
	Email       string          `json:"email,omitempty"`
	Status      string          `json:"status"`
	Certified   bool            `json:"certified"`
	Featured    bool            `json:"featured"`
	VerifiedAt  string          `json:"verified_at,omitempty"`
	Fee         string          `json:"fee,omitempty"`
	ApplicationProcess string  `json:"application_process,omitempty"`
	WaitTime    string          `json:"wait_time,omitempty"`
	IsMohcdFunded bool          `json:"is_mohcd_funded"`
	GeoLoc      *GeoLoc         `json:"_geoloc,omitempty"`
	Addresses   []IndexAddress  `json:"addresses"`
	Schedule    *IndexSchedule  `json:"schedule,omitempty"`
	ResourceSchedule *IndexSchedule `json:"resource_schedule,omitempty"`
	OpenTimes   []IndexOpenTime `json:"open_times"`
	ServiceOf   *IndexServiceOf `json:"service_of,omitempty"`
	Categories  []IndexCategory `json:"categories"`
	Eligibilities []IndexEligibility `json:"eligibilities"`
	Phones      []IndexPhone    `json:"phones"`
	Documents   []IndexDocument `json:"documents"`
	Instructions []IndexInstruction `json:"instructions"`
	Notes       []IndexNote     `json:"notes"`
}

// GeoLoc represents geographic coordinates for Algolia geo search.
type GeoLoc struct {
	Lat float64 `json:"lat"`
	Lng float64 `json:"lng"`
}

// IndexAddress represents an address in the Algolia index.
type IndexAddress struct {
	ID            int     `json:"id"`
	City          string  `json:"city"`
	StateProvince string  `json:"state_province"`
	Address1      string  `json:"address_1"`
	PostalCode    string  `json:"postal_code"`
	Latitude      float64 `json:"latitude,omitempty"`
	Longitude     float64 `json:"longitude,omitempty"`
}

// IndexSchedule represents a schedule in the Algolia index.
type IndexSchedule struct {
	ID         int              `json:"id"`
	HoursKnown bool            `json:"hours_known"`
	Days       []IndexScheduleDay `json:"schedule_days"`
}

// IndexScheduleDay represents a single schedule day entry.
type IndexScheduleDay struct {
	ID        int    `json:"id"`
	Day       string `json:"day"`
	OpensAt   *int32 `json:"opens_at,omitempty"`
	ClosesAt  *int32 `json:"closes_at,omitempty"`
	OpenTime  string `json:"open_time,omitempty"`
	OpenDay   string `json:"open_day,omitempty"`
	CloseTime string `json:"close_time,omitempty"`
	CloseDay  string `json:"close_day,omitempty"`
}

// IndexOpenTime represents an open time entry derived from schedule days.
type IndexOpenTime struct {
	Day       string `json:"day"`
	OpensAt   *int32 `json:"opens_at,omitempty"`
	ClosesAt  *int32 `json:"closes_at,omitempty"`
}

// IndexPhone represents a phone in the Algolia index.
type IndexPhone struct {
	ID          int    `json:"id"`
	Number      string `json:"number"`
	ServiceType string `json:"service_type"`
}

// IndexCategory represents a category in the Algolia index.
type IndexCategory struct {
	ID       int    `json:"id"`
	Name     string `json:"name"`
	TopLevel bool   `json:"top_level"`
}

// IndexNote represents a note in the Algolia index.
type IndexNote struct {
	ID   int    `json:"id"`
	Note string `json:"note"`
}

// IndexEligibility represents an eligibility in the Algolia index.
type IndexEligibility struct {
	ID          int    `json:"id"`
	Name        string `json:"name"`
	FeatureRank *int32 `json:"feature_rank,omitempty"`
}

// IndexDocument represents a document in the Algolia index.
type IndexDocument struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
	URL  string `json:"url"`
}

// IndexInstruction represents an instruction in the Algolia index.
type IndexInstruction struct {
	ID          int    `json:"id"`
	Instruction string `json:"instruction"`
}

// IndexServiceOf represents the parent resource of a service.
type IndexServiceOf struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}
