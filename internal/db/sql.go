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
