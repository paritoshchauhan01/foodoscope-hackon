// src/routes.ts
import { Router } from 'express'
import * as controllers from './controllers'
import { requireAuth } from './middleware'

const router = Router()

router.post('/auth/login', controllers.login)
router.post('/auth/demo', controllers.demoLogin)
router.post('/onboarding', requireAuth, controllers.saveOnboarding)
router.get('/onboarding', requireAuth, controllers.getOnboarding)
router.post('/recipes/search', requireAuth, controllers.searchRecipes)
router.get('/recipes/:id', requireAuth, controllers.getRecipeById)
router.post('/substitutions', requireAuth, controllers.findSubstitutions)
router.get('/user/profile', requireAuth, controllers.getUserProfile)
router.get('/user/searches', requireAuth, controllers.getRecentSearches)

export default router