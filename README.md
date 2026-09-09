# Pole Fitness Instructor Management App

A private teaching management application for pole fitness instructors, built with Next.js 14, TypeScript, and Supabase.

## 🎯 Project Status: Phase 1 - Foundation (In Progress)

### ✅ Completed
- Project setup (Next.js 14, TypeScript, Tailwind CSS)
- Supabase integration with authentication
- Database schema (9 core tables with Row Level Security)
- Authentication system (login, signup, password reset)
- Protected routes with middleware
- Base UI components

### 🚧 In Progress
- Dashboard layout
- Students management module
- Terms & Classes modules
- Lesson planning interface
- Attendance recording system

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- Supabase account

### Installation

1. **Install dependencies**
   ```bash
   npm install --legacy-peer-deps
   ```

2. **Configure environment variables**

   Create `.env.local`:
   ```bash
   NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
   ```

3. **Set up database**

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

4. **Run development server**
   ```bash
   npm run dev
   ```

   Open [http://localhost:3000](http://localhost:3000)

5. **Create your instructor account**

   Navigate to `/signup` and create your account

## 📊 Database Schema

**Core Tables (Phase 1)**:
- `profiles` - Instructor profiles
- `students` - Student information
- `levels` - Skill levels (Beginner, Intermediate, Advanced)
- `terms` - Teaching terms/sessions
- `term_students` - Student enrollment in terms
- `classes` - Individual class sessions
- `class_lessons` - Lesson plans
- `lesson_items` - Lesson plan details
- `class_students` - Student attendance

**Planned for Phase 2/3**:
- Tricks library and categories
- Exercise database
- Student progression tracking
- Media uploads (photos/videos)
- Performance milestones

## 🔐 Security

- Row Level Security (RLS) enabled on all tables
- Middleware-protected routes
- Instructor-scoped data access
- Environment variables for sensitive configuration

## 🛠️ Tech Stack

- **Framework**: Next.js 14 with App Router
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Database**: PostgreSQL (Supabase)
- **Authentication**: Supabase Auth
- **Form Validation**: React Hook Form + Zod
- **UI Components**: Lucide React icons, class-variance-authority

## 📖 Key Features

### Current Phase (Phase 1)
- ✅ User authentication and authorization
- 🚧 Student management (CRUD operations)
- 🚧 Term creation with automatic class generation
- 🚧 Flexible lesson planning
- 🚧 Attendance tracking and notes
- 🚧 Class completion workflow

### Future Phases
- **Phase 2**: Trick/exercise libraries with categorization
- **Phase 3**: Student progression tracking with media support
- **Phase 4**: Mobile-optimized UX, Progressive Web App

## 📁 Project Structure

```
pole-fitness-app/
├── app/                    # Next.js app directory
│   ├── (auth)/            # Authentication pages
│   ├── (dashboard)/       # Protected dashboard pages
│   └── layout.tsx         # Root layout
├── components/            # Reusable React components
├── lib/                   # Utility functions and configs
│   ├── supabase/         # Supabase client and middleware
│   └── utils.ts          # Helper functions
├── supabase/             # Database migrations and seeds
└── types/                # TypeScript type definitions
```

## 🐛 Troubleshooting

**Node version issues**
```bash
nvm install 20 && nvm use 20
```

**Dependency conflicts**
```bash
npm install --legacy-peer-deps
```

**Database connection issues**
- Verify Supabase URL and anon key in `.env.local`
- Ensure Supabase project is active
- Check Auth Site URL settings in Supabase dashboard

**RLS policy errors**
- Verify all migrations ran successfully
- Ensure you're logged in
- Check that data belongs to your instructor account

## 📚 Documentation

- [Setup Guide](./SETUP_GUIDE.md) - Detailed setup instructions
- [Implementation Status](./IMPLEMENTATION_STATUS.md) - Development progress

## 🚀 Deployment

This app uses Supabase authentication and server-side features, requiring a Node.js runtime.

### Recommended Platforms

**Vercel (Recommended)**
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel
```

Add environment variables in Vercel dashboard:
- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`

**Other Options**
- Railway
- Render
- Fly.io
- Any Node.js hosting platform

### Local Build
```bash
npm run build
npm start
```

**Note**: Static export (GitHub Pages) is not compatible with this app due to server-side authentication and Server Actions.

## 📞 Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [React Hook Form](https://react-hook-form.com/)

---

**Version**: 0.1.0
**Node**: 20+
**Database**: PostgreSQL 15+ (Supabase)
**License**: Private
