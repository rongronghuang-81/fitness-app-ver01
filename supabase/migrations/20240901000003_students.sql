-- Students table
CREATE TABLE students (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  instructor_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  first_name TEXT NOT NULL,
  last_name TEXT,
  preferred_name TEXT,
  email TEXT,
  phone TEXT,
  date_joined DATE DEFAULT CURRENT_DATE,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  current_level_id UUID REFERENCES levels(id) ON DELETE SET NULL,
  goals TEXT,
  general_notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE students ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON students
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Create indexes
CREATE INDEX idx_students_instructor ON students(instructor_id);
CREATE INDEX idx_students_active ON students(active);
CREATE INDEX idx_students_level ON students(current_level_id);
CREATE INDEX idx_students_name ON students(first_name, last_name);

-- RLS Policies
CREATE POLICY "Instructors can view own students"
  ON students
  FOR SELECT
  USING (auth.uid() = instructor_id);

CREATE POLICY "Instructors can create own students"
  ON students
  FOR INSERT
  WITH CHECK (auth.uid() = instructor_id);

CREATE POLICY "Instructors can update own students"
  ON students
  FOR UPDATE
  USING (auth.uid() = instructor_id);

CREATE POLICY "Instructors can delete own students"
  ON students
  FOR DELETE
  USING (auth.uid() = instructor_id);
