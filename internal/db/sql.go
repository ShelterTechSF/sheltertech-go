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
