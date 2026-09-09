# Setup Guide - Pole Fitness App

Complete step-by-step guide to set up and run the application.

## Prerequisites

- **Node.js 20+** - [Download here](https://nodejs.org/)
- **Supabase Account** - [Sign up here](https://supabase.com)
- **Git** (optional)

---

## Step 1: Supabase Project Setup

### 1.1 Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign in
2. Click "New Project"
3. Fill in:
   - **Name**: `pole-fitness-app` (or your choice)
   - **Database Password**: Create a strong password (save it!)
   - **Region**: Singapore (Southeast Asia)
4. Click "Create new project"
5. Wait 2-3 minutes for project provisioning

### 1.2 Get Project Credentials

1. In your Supabase project dashboard, click "Project Settings" (gear icon)
2. Go to "API" section
3. Copy these values (you'll need them later):
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **anon public key** (long string starting with `eyJ...`)

---

## Step 2: Install Application

### 2.1 Navigate to Project Directory

```bash
cd /Users/rongrong/pole-fitness-app
```

### 2.2 Install Dependencies

```bash
npm install
```

This may take 2-3 minutes.

### 2.3 Configure Environment Variables

1. Open the `.env.local` file (already created)
2. Replace the values with your Supabase credentials:

```bash
NEXT_PUBLIC_SUPABASE_URL=https://your-actual-project-id.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-actual-anon-key-here
```

**Important**: Keep `.env.local` private. Never share or commit it.

---

## Step 3: Database Setup

### 3.1 Open SQL Editor

1. In Supabase dashboard, click "SQL Editor" in left sidebar
2. Click "New query"

### 3.2 Run Migrations (In Order!)

Execute each migration file in the SQL Editor:

#### Migration 1: Init

```sql
-- Copy entire contents of supabase/migrations/20240901000000_init.sql
-- Paste in SQL Editor
-- Click "Run"
```

#### Migration 2: Profiles

```sql
-- Copy entire contents of supabase/migrations/20240901000001_profiles.sql
-- Paste and Run
```

#### Migration 3: Levels

```sql
-- Copy entire contents of supabase/migrations/20240901000002_levels.sql
-- Paste and Run
```

#### Migration 4: Students

```sql
-- Copy entire contents of supabase/migrations/20240901000003_students.sql
-- Paste and Run
```

#### Migration 5: Terms

```sql
-- Copy entire contents of supabase/migrations/20240901000004_terms.sql
-- Paste and Run
```

#### Migration 6: Term Students

```sql
-- Copy entire contents of supabase/migrations/20240901000005_term_students.sql
-- Paste and Run
```

#### Migration 7: Classes

```sql
-- Copy entire contents of supabase/migrations/20240901000006_classes.sql
-- Paste and Run
```

#### Migration 8: Class Lessons

```sql
-- Copy entire contents of supabase/migrations/20240901000007_class_lessons.sql
-- Paste and Run
```

#### Migration 9: Lesson Items

```sql
-- Copy entire contents of supabase/migrations/20240901000008_lesson_items.sql
-- Paste and Run
```

#### Migration 10: Class Students

```sql
-- Copy entire contents of supabase/migrations/20240901000009_class_students.sql
-- Paste and Run
```

### 3.3 Verify Tables Created

1. In Supabase dashboard, click "Table Editor"
2. You should see these tables:
   - profiles
   - students
   - levels
   - terms
   - term_students
   - classes
   - class_lessons
   - lesson_items
   - class_students

### 3.4 (Optional) Load Demo Data

Only do this for testing/development:

1. In SQL Editor, create new query
2. Copy contents of `supabase/seed.sql`
3. Run the query

**Warning**: This will only work after you've created your first instructor account (Step 5).

---

## Step 4: Run Application

```bash
npm run dev
```

You should see:
```
  ▲ Next.js 16.3.4
  - Local:        http://localhost:3000

 ✓ Starting...
 ✓ Ready in 2.5s
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## Step 5: Create Your Account

### 5.1 Sign Up

1. Navigate to [http://localhost:3000/signup](http://localhost:3000/signup)
2. Fill in:
   - **First Name**: Your first name
   - **Last Name**: Your last name (optional)
   - **Email**: Your email address
   - **Password**: Minimum 6 characters
3. Click "Create account"

### 5.2 Verify Account Created

1. Go to Supabase dashboard > Authentication > Users
2. You should see your account listed
3. Go to Table Editor > profiles
4. You should see a profile record with your email

---

## Step 6: Set Up Initial Data

### 6.1 Create Skill Levels

1. In the app, go to Settings > Levels (when implemented)
2. Create levels:
   - Beginner
   - Intermediate
   - Advanced

**Or run this SQL in Supabase**:

```sql
INSERT INTO levels (instructor_id, name, description, sort_order, active)
SELECT
  id,
  'Beginner',
  'Foundation skills and basic spins',
  1,
  true
FROM profiles
WHERE email = 'your-email@example.com'
UNION ALL
SELECT
  id,
  'Intermediate',
  'Inverts and more complex tricks',
  2,
  true
FROM profiles
WHERE email = 'your-email@example.com'
UNION ALL
SELECT
  id,
  'Advanced',
  'Advanced tricks and combinations',
  3,
  true
FROM profiles
WHERE email = 'your-email@example.com';
```

(Replace `your-email@example.com` with your actual email)

---

## Step 7: Test the Application

### 7.1 Create a Student

1. Navigate to Students (when implemented)
2. Click "Add Student"
3. Enter student details
4. Save

### 7.2 Create a Term

1. Navigate to Terms
2. Click "Create Term"
3. Fill in:
   - Name: "September 2026 Intermediate"
   - Start Date: 2026-09-09
   - Weekday: Wednesday
   - Start Time: 19:00
   - Duration: 60 minutes
   - Number of Weeks: 6
4. Save

This should automatically create 6 weekly classes.

### 7.3 Enroll Student in Term

1. Open the term
2. Click "Add Students"
3. Select student
4. Save

### 7.4 Plan a Lesson

1. Open Week 1 class
2. Create lesson plan
3. Add warmup, conditioning, tricks, cooldown
4. Save

### 7.5 Record Class Completion

1. After teaching the class, open it
2. Mark attendance
3. Record what actually happened
4. Add student-specific notes
5. Mark class as complete

---

## Troubleshooting

### "Cannot connect to database"

**Check**:
- `.env.local` has correct Supabase URL and anon key
- Supabase project is active (not paused)
- Internet connection is working

**Fix**:
```bash
# Restart dev server
# Press Ctrl+C to stop
npm run dev
```

### "RLS policy violation" or "Permission denied"

**Check**:
- You're logged in
- The data belongs to your instructor account
- RLS policies were created (all migration files run)

**Fix**:
- Log out and log back in
- Verify all migrations ran successfully
- Check Supabase > Authentication > Policies

### "Module not found" errors

```bash
# Clear and reinstall
rm -rf node_modules package-lock.json
npm install
```

### Port 3000 already in use

```bash
# Use different port
PORT=3001 npm run dev
```

### Node version issues

```bash
# Check Node version
node --version
# Should show v20.x.x or higher

# If lower, install Node 20+
# Visit https://nodejs.org
# Or use nvm:
nvm install 20
nvm use 20
```

---

## Next Steps

Once the foundation is working:

1. Complete Students module UI
2. Complete Terms module UI
3. Complete Classes module UI
4. Build Lesson Planning interface
5. Build Attendance Recording
6. Build Dashboard homepage

Then proceed to Phase 2 (Tricks/Exercises) and Phase 3 (Progression/Media).

---

## Getting Help

- **Supabase Issues**: [Supabase Discord](https://discord.supabase.com)
- **Next.js Issues**: [Next.js Docs](https://nextjs.org/docs)
- **Database Schema**: Check migration files in `supabase/migrations/`

---

## Security Notes

✅ **Safe to share**:
- Project URL (NEXT_PUBLIC_SUPABASE_URL)
- Anon key (NEXT_PUBLIC_SUPABASE_ANON_KEY)

❌ **Never share**:
- Database password
- Service role key (not used in this app)
- `.env.local` file contents

🔒 **Row Level Security (RLS)** protects your data:
- Even with the anon key, users can only access their own data
- All tables have RLS enabled
- Policies restrict access by instructor_id

---

**You're all set!** 🎉

The database is configured, authentication works, and you're ready to build the rest of the application.
