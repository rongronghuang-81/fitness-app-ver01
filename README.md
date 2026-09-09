# Pole Fitness Instructor Management App

A private teaching management application for pole fitness instructors.

## 🎯 Status: Phase 1 - Foundation (In Progress)

### ✅ Completed
- Project setup (Next.js 14, TypeScript, Tailwind)
- Supabase configuration
- Database migrations (9 core tables with RLS)
- Authentication (login, signup, password reset)
- Base UI components

### 🚧 In Progress
- Protected dashboard layout
- Students module
- Terms & Classes modules
- Lesson planning
- Attendance recording

## 🚀 Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Supabase

Create a `.env.local` file:
```bash
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 3. Set Up Database

Run migrations in Supabase SQL Editor (in order):
- `supabase/migrations/20240901000000_init.sql`
- `supabase/migrations/20240901000001_profiles.sql`
- `supabase/migrations/20240901000002_levels.sql`
- `supabase/migrations/20240901000003_students.sql`
- `supabase/migrations/20240901000004_terms.sql`
- `supabase/migrations/20240901000005_term_students.sql`
- `supabase/migrations/20240901000006_classes.sql`
- `supabase/migrations/20240901000007_class_lessons.sql`
- `supabase/migrations/20240901000008_lesson_items.sql`
- `supabase/migrations/20240901000009_class_students.sql`

Optional: Run `supabase/seed.sql` for demo data

### 4. Run Development Server
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

### 5. Create Account
Navigate to `/signup` and create your instructor account.

## 📊 Database Schema

**Core Tables (Phase 1)**:
- profiles, students, levels
- terms, term_students
- classes, class_lessons, lesson_items, class_students

**Coming** in Phase 2/3:
- Tricks, exercises, categories
- Student progression, milestones, media

## 🔐 Security

- Row Level Security (RLS) on all tables
- Middleware-protected routes
- Instructor-only data access

## 🛠️ Tech Stack

- Next.js 16, TypeScript, Tailwind CSS
- Supabase (PostgreSQL, Auth, Storage)
- React Hook Form, Zod validation

## 📖 Key Features

### Phase 1 (Current)
- Student management
- Term creation (4/6/8 weeks)
- Automatic class generation
- Lesson planning (free-text)
- Attendance tracking
- Class completion workflow

### Future Phases
- Trick/exercise libraries (Phase 2)
- Progression tracking & media (Phase 3)
- Mobile-optimized UX, PWA (Phase 4)

## 🐛 Troubleshooting

**Node version**: Requires Node.js 20+
```bash
nvm install 20 && nvm use 20
```

**Database issues**: Verify Supabase URL/key in `.env.local`

**Auth issues**: Check Supabase Auth Site URL matches your domain

## 📞 Resources

- [Supabase Docs](https://supabase.com/docs)
- [Next.js Docs](https://nextjs.org/docs)
- [Vercel Deployment](https://vercel.com/docs)

---

**Version**: 0.1.0
**Node**: 20+
**Database**: PostgreSQL 15+ (Supabase)
# fitness-app-ver01
