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

const serviceByIDSql = `
SELECT id, resource_id
FROM public.services
WHERE id = $1
`
