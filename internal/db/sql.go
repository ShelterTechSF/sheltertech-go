package db

const categoriesSql = `
SELECT id, name, top_level, featured 
FROM public.categories
ORDER BY name
`

const categoriesByTopLevelSql = `
SELECT id, name, top_level, featured 
FROM public.categories
WHERE top_level = $1
ORDER BY name DESC
`

const categoriesByIDSql = `
SELECT id, name, top_level, featured 
FROM public.categories
WHERE id = $1
`

const categoriesByServiceIDSql = `
SELECT c.id, c.name, c.top_level, c.featured 
FROM public.categories c
LEFT JOIN public.categories_services cs on c.id = cs.category_id
WHERE cs.service_id = $1
ORDER BY c.id
`

const categoriesByResourceIDSql = `
SELECT c.id, c.name, c.top_level, c.featured 
FROM public.categories c
LEFT JOIN public.categories_resources cs on c.id = cs.category_id
WHERE cs.resource_id = $1
ORDER BY c.id
`

const notesByServiceIDSql = `
SELECT n.id, n.note, n.created_at, n.updated_at 
FROM public.notes n
WHERE n.service_id = $1
`

const notesByResourceIDSql = `
SELECT n.id, n.note, n.created_at, n.updated_at 
FROM public.notes n
WHERE n.resource_id = $1
`

const addressesByServiceIDSql = `
SELECT a.id, a.attention, a.address_1, a.address_2, a.address_3, a.address_4, a.city, a.state_province, a.postal_code, a.resource_id, a.latitude, a.longitude, a.online, a.region, a.name ,a.description , a.transportation
FROM public.addresses a
LEFT JOIN public.addresses_services ads on a.id = ads.address_id
WHERE ads.service_id = $1
ORDER BY a.id
`

const addressesByResourceIDSql = `
SELECT a.id, a.attention, a.address_1, a.address_2, a.address_3, a.address_4, a.city, a.state_province, a.postal_code, a.resource_id, a.latitude, a.longitude, a.online, a.region, a.name ,a.description , a.transportation
FROM public.addresses a
WHERE a.resource_id = $1
ORDER BY a.id
`

const folderByIDSql = `
SELECT id, name, "order", user_id
FROM public.folders
WHERE id = $1
`

const foldersByUserIDSql = `
SELECT f.id, f.name, f.order, f.user_id
FROM public.folders f
WHERE f.user_id = $1
`

const createFolder = `
INSERT INTO public.folders (name, "order", user_id, created_at, updated_at)
VALUES ($1, $2, $3, now(), now())
RETURNING id
`

const updateFolder = `
UPDATE public.folders f
SET name = $2, "order" = $3
WHERE f.id = $1
`

const deleteFolder = `
DELETE FROM public.folders f
WHERE f.id = $1
`

// const bookmarksByFolderIDSQL = `
// SELECT b.if, b.order, b.service_id
// FROM public.bookmarks b
// WHERE b.folder_id = $1
// `

const phonesByResourceIDSql = `
SELECT p.id, p.number, p.service_type
FROM public.phones p
WHERE p.resource_id = $1
`

const eligibilitiesByServiceIDSql = `
SELECT e.id, e.name, e.feature_rank
FROM public.eligibilities e
LEFT JOIN public.eligibilities_services es on e.id = es.eligibility_id
WHERE es.service_id = $1
`

const instructionsByServiceIDSql = `
SELECT i.id, i.instruction
FROM public.instructions i
WHERE i.service_id = $1
`
const documentsByServiceIDSql = `
SELECT d.id, d.name, d.url, d.description
FROM public.documents d
LEFT JOIN public.documents_services ds on d.id = ds.document_id
WHERE ds.service_id = $1
`
const categoryServiceCounts = `
SELECT c.name, count(s.id) as services
FROM categories c
JOIN categories_services cs ON cs.category_id = c.id
JOIN services s ON s.id = cs.service_id
WHERE s.status = 1
GROUP BY c.name
ORDER BY c.name asc
`

const categoryResourceCounts = `
SELECT c.name, count(r.id) as resources
FROM categories c
JOIN categories_resources cr ON cr.category_id = c.id
JOIN resources r ON r.id = cr.resource_id
WHERE r.status = 1
GROUP BY c.name
ORDER BY c.name asc
`

const categoriesByFeaturedSql = `
SELECT id, name, top_level, featured 
FROM public.categories
WHERE featured = true
`

const subCategoriesByIDSql = `
SELECT id, name, top_level, featured 
FROM public.categories
WHERE id in (SELECT child_id from public.category_relationships WHERE parent_id = $1)
`

const submitChangeRequest = `
INSERT INTO public.change_requests (type, object_id, status, action, resource_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())`

const findBookmarksSql = `
SELECT id, "order", user_id, folder_id, service_id, resource_id from public.bookmarks`

const submitBookmark = `
INSERT INTO public.bookmarks ("order", user_id, folder_id, resource_id, service_id, created_at, updated_at)
VALUES ($1, $2, $3, $4, $5, now(), now())`

const updateBookmark = `
UPDATE public.bookmarks SET "order" = $2, user_id = $3, folder_id= $4, resource_id = $5, service_id = $6 where id = $1`

const deleteBookmarkByIDSql = `
DELETE FROM public.bookmarks WHERE id = $1
`

const serviceByIDSql = `
SELECT id, created_at, updated_at, name, long_description, eligibility, required_documents, fee, application_process, resource_id, verified_at, email, status, certified, program_id, interpretation_services, url, wait_time, contact_id, funding_id, alternate_name, certified_at, featured, source_attribution, internal_note, short_description
FROM public.services
WHERE id = $1
`

const approvedServicesByResourceIDSql = `
SELECT id, created_at, updated_at, name, long_description, eligibility, required_documents, fee, application_process, resource_id, verified_at, email, status, certified, program_id, interpretation_services, url, wait_time, contact_id, funding_id, alternate_name, certified_at, featured, source_attribution, internal_note, short_description
FROM public.services
WHERE resource_id = $1 and status = 1
`

const programByIDSql = `
SELECT id, name, alterante_name, description
FROM public.programs
WHERE id = $1
`

const resourceByIDSql = `
SELECT id, name, short_description, long_description, website, verified_at, email, status, certified, alternate_name, legal_status, contact_id, funding_id, certified_at, featured, source_attribution, internal_note, updated_at
FROM public.resources
WHERE id = $1
`
const scheduleByServiceIDSql = `
SELECT s.id, s.hours_known
FROM public.schedules s
WHERE s.service_id = $1 LIMIT 1
`

const scheduleByResourceIDSql = `
SELECT s.id, s.hours_known
FROM public.schedules s
WHERE s.resource_id = $1 LIMIT 1
`

const scheduleDaysByScheduleIDSql = `
SELECT sd.id, sd.day, sd.opens_at, sd.closes_at, sd.open_time, sd.open_day, sd.close_time, sd.close_day
FROM public.schedule_days sd
WHERE sd.schedule_id = $1
`

const userByUserExternalIDSql = `
SELECT u.id, u.name, u.organization, u.user_external_id, u.email
FROM public.users u
WHERE u.user_external_id = $1
`
