-- Seed data for development
-- This file contains demo data for testing

-- Note: In production, you'll create the instructor account via Supabase Auth UI or signup page
-- This seed assumes an instructor account exists

-- Function to get instructor ID (for local dev, you may need to manually insert this)
-- For now, we'll create placeholder data that can be associated with an instructor after signup

-- Insert demo levels
INSERT INTO levels (id, instructor_id, name, description, sort_order, active) VALUES
  ('00000000-0000-0000-0000-000000000001',
   (SELECT id FROM profiles LIMIT 1), -- Will use the first instructor
   'Beginner',
   'Foundation skills and basic spins',
   1,
   true),
  ('00000000-0000-0000-0000-000000000002',
   (SELECT id FROM profiles LIMIT 1),
   'Intermediate',
   'Inverts and more complex tricks',
   2,
   true),
  ('00000000-0000-0000-0000-000000000003',
   (SELECT id FROM profiles LIMIT 1),
   'Advanced',
   'Advanced tricks and combinations',
   3,
   true)
ON CONFLICT (id) DO NOTHING;

-- Insert demo students
INSERT INTO students (id, instructor_id, first_name, last_name, preferred_name, email, date_joined, active, current_level_id, goals) VALUES
  ('10000000-0000-0000-0000-000000000001',
   (SELECT id FROM profiles LIMIT 1),
   'Sarah',
   'Chen',
   'Sarah',
   'sarah.chen@example.com',
   CURRENT_DATE - INTERVAL '60 days',
   true,
   '00000000-0000-0000-0000-000000000002',
   'Master shoulder mount and ayesha'),
  ('10000000-0000-0000-0000-000000000002',
   (SELECT id FROM profiles LIMIT 1),
   'Michelle',
   'Tan',
   'Michelle',
   'michelle.tan@example.com',
   CURRENT_DATE - INTERVAL '30 days',
   true,
   '00000000-0000-0000-0000-000000000001',
   'Build strength and learn basic spins'),
  ('10000000-0000-0000-0000-000000000003',
   (SELECT id FROM profiles LIMIT 1),
   'Jane',
   'Wong',
   'Jane',
   'jane.wong@example.com',
   CURRENT_DATE - INTERVAL '90 days',
   true,
   '00000000-0000-0000-0000-000000000002',
   'Improve flexibility and learn advanced transitions')
ON CONFLICT (id) DO NOTHING;

-- Insert demo term
INSERT INTO terms (id, instructor_id, name, description, level_id, start_date, weekday, start_time, duration_minutes, number_of_weeks, location, status) VALUES
  ('20000000-0000-0000-0000-000000000001',
   (SELECT id FROM profiles LIMIT 1),
   'September 2026 Intermediate',
   'Intermediate pole skills focusing on inverts and shoulder mounts',
   '00000000-0000-0000-0000-000000000002',
   '2026-09-09',  -- Wednesday
   3,  -- Wednesday
   '19:00:00',
   60,
   6,
   'Studio A, Singapore',
   'active')
ON CONFLICT (id) DO NOTHING;

-- Enroll students in term
INSERT INTO term_students (term_id, student_id, status) VALUES
  ('20000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'enrolled'),
  ('20000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000003', 'enrolled')
ON CONFLICT (term_id, student_id) DO NOTHING;

-- Generate classes for the term (6 weeks starting Sept 9, 2026)
INSERT INTO classes (id, term_id, instructor_id, week_number, scheduled_date, start_time, duration_minutes, status) VALUES
  ('30000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', (SELECT id FROM profiles LIMIT 1), 1, '2026-09-09', '19:00:00', 60, 'planned'),
  ('30000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000001', (SELECT id FROM profiles LIMIT 1), 2, '2026-09-16', '19:00:00', 60, 'planned'),
  ('30000000-0000-0000-0000-000000000003', '20000000-0000-0000-0000-000000000001', (SELECT id FROM profiles LIMIT 1), 3, '2026-09-23', '19:00:00', 60, 'planned'),
  ('30000000-0000-0000-0000-000000000004', '20000000-0000-0000-0000-000000000001', (SELECT id FROM profiles LIMIT 1), 4, '2026-09-30', '19:00:00', 60, 'planned'),
  ('30000000-0000-0000-0000-000000000005', '20000000-0000-0000-0000-000000000001', (SELECT id FROM profiles LIMIT 1), 5, '2026-10-07', '19:00:00', 60, 'planned'),
  ('30000000-0000-0000-0000-000000000006', '20000000-0000-0000-0000-000000000001', (SELECT id FROM profiles LIMIT 1), 6, '2026-10-14', '19:00:00', 60, 'planned')
ON CONFLICT (id) DO NOTHING;
