# NutriContext - Personalized Recipe Recommendations

A full-stack application that recommends recipes based on user context including life stage, location, allergies, dietary restrictions, and cuisine preferences. Features intelligent ingredient substitution using flavor molecule analysis.

---

## 🚀 Quick Start - Run Everything

### **Option 1: Batch File (Recommended for Windows)**
Simply double-click this file from Windows Explorer:
```
run-all.bat
```
This opens 2 new terminals and starts both Frontend and Backend automatically.

### **Option 2: PowerShell Script**
```powershell
.\run-all.ps1
```

### **Option 3: Manual (Run commands separately)**

**Terminal 1 - Frontend:**
```bash
cd frontend
npm run dev
```

**Terminal 2 - Backend:**
```bash
cd backend
npm run dev
```

**Make sure MongoDB is running:**
```bash
mongod
```

---

## 📋 Prerequisites

- **Node.js** (v16+) - [Download](https://nodejs.org/)
- **MongoDB** - Install locally or use MongoDB Atlas
- **npm** (comes with Node.js)

---

## 🌐 Services

Once running, access:

| Service | URL | Purpose |
|---------|-----|---------|
| Frontend | http://localhost:3000 | React Next.js app |
| Backend API | http://localhost:3001 | Express server |
| MongoDB | localhost:27017 | Database |

---

## 🔐 Demo Account

**Email:** `demo@nutricontext.com`  
**Password:** `Demo123!`

Or click **"Try Demo"** on login page for instant access.

---

## 📁 Project Structure

```
nutrifit/
├── frontend/              # Next.js React app
│   ├── app/              # Pages & routing
│   ├── components/       # React components
│   ├── lib/              # API & utilities
│   └── public/           # Static assets
├── backend/              # Express.js server
│   ├── src/
│   │   ├── services/     # Business logic (recipes, flavor DB, scoring)
│   │   ├── controllers.ts # Route handlers
│   │   ├── models.ts     # MongoDB schemas
│   │   ├── routes.ts     # API endpoints
│   │   └── middleware.ts # Auth & error handling
│   └── dist/             # Compiled output
├── docs/                 # Documentation
├── run-all.bat           # Start all services (Windows)
└── run-all.ps1           # Start all services (PowerShell)
```

---

## 🛠️ Development Commands

### Frontend
```bash
cd frontend

# Development server
npm run dev

# Production build
npm run build

# Start production server
npm start

# Lint code
npm run lint
```

### Backend
```bash
cd backend

# Development server with auto-reload
npm run dev

# Build TypeScript
npm run build

# Start production server
npm start
```

---

## 🔧 Configuration

### Frontend Environment
Create `frontend/.env.local`:
```env
NEXT_PUBLIC_API_URL=http://localhost:3001/api
```

### Backend Environment
Create `backend/.env`:
```env
NODE_ENV=development
PORT=3001
MONGODB_URI=mongodb://localhost:27017/nutricontext_dev
JWT_SECRET=your_secret_key_min_32_chars
FRONTEND_URL=http://localhost:3000
```

---

## 📚 Features

### User Authentication
- Login with email/password
- Demo account for testing
- JWT token-based auth

### User Onboarding
- Life stage selection (new mother, parent, general, elderly)
- Location & climate preference
- Allergies and dietary restrictions
- Favorite cuisines

### Recipe Search
- Context-aware recipe recommendations
- Personalized scoring based on user profile
- Allergy safety warnings
- Top match percentage display

### Ingredient Substitutions
- Find alternatives using FlavorDB molecular analysis
- Shows shared flavor molecules
- Nutrition impact comparison
- Safety checks against allergies

### User Profile
- View preferences
- Search history
- Personalization settings

---

## 🔌 API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/demo` - Demo login

### Onboarding
- `POST /api/onboarding` - Save user preferences
- `GET /api/onboarding` - Get saved preferences

### Recipes
- `POST /api/recipes/search` - Search recipes
- `GET /api/recipes/:id` - Get recipe details

### Substitutions
- `POST /api/substitutions` - Find ingredient alternatives

### User
- `GET /api/user/profile` - User profile info
- `GET /api/user/searches` - Recent searches

---

## 🗄️ Database Schema

### Users
```typescript
{
  email: string (unique),
  passwordHash: string,
  name: string,
  createdAt: Date
}
```

### UserContext
```typescript
{
  userId: ObjectId,
  lifeStage: string,
  location: { country, climate },
  allergies: [string],
  dietaryRestrictions: [string],
  favoriteCuisines: [string],
  onboardingCompleted: boolean
}
```

### RecipeCache
```typescript
{
  recipeId: string,
  data: object,
  createdAt: Date (expires after 24h)
}
```

### SearchHistory
```typescript
{
  userId: ObjectId,
  query: string,
  timestamp: Date
}
```

---

## 🎯 Scoring Algorithm

Recipes are scored 0-100 based on:

1. **Allergy Safety** - 0 points if contains allergen
2. **Dietary Compliance** - 0 points if violates restriction
3. **Cuisine Match** - +20 points if favorite cuisine
4. **Climate Boost** - +15 points for climate-appropriate recipes
5. **Life Stage Boost** - +10 points for life-stage-specific nutritional needs

---

## 🐛 Troubleshooting

### "Cannot find module..." errors
```bash
# Clean install
rm -rf node_modules package-lock.json
npm install
```

### MongoDB connection failed
- Ensure MongoDB is running: `mongod`
- Check `MONGODB_URI` in `backend/.env`
- For cloud: Use MongoDB Atlas connection string

### Port already in use
- Frontend uses port 3000
- Backend uses port 3001
- MongoDB uses port 27017

Change ports in `.env` files as needed.

### Frontend can't reach backend
- Verify backend is running on correct port
- Check `NEXT_PUBLIC_API_URL` in frontend
- Ensure CORS is enabled in backend

---

## 📦 Dependencies

### Frontend
- Next.js 13
- React 18
- Tailwind CSS
- Axios
- Lucide Icons

### Backend
- Express.js
- MongoDB & Mongoose
- JWT (jsonwebtoken)
- bcrypt
- Axios

---

## 🚀 Deployment

### Frontend (Vercel)
```bash
npm run build
# Deploy dist/ to Vercel
```

### Backend (Heroku or Railway)
```bash
npm run build
npm start
# Set environment variables in hosting platform
```

---

## 📝 License

Private project for NutriContext hackathon.

---

## 🤝 Support

For issues or questions, check the `/docs` folder or contact the development team.
