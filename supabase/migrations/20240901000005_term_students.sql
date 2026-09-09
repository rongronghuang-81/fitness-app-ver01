-- Term Students join table
CREATE TABLE term_students (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  term_id UUID NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'enrolled' CHECK (status IN ('enrolled', 'completed', 'withdrawn')),
  joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Ensure a student can only be enrolled once per term
  UNIQUE(term_id, student_id)
);

-- Enable RLS
ALTER TABLE term_students ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON term_students
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Create indexes
CREATE INDEX idx_term_students_term ON term_students(term_id);
CREATE INDEX idx_term_students_student ON term_students(student_id);

-- RLS Policies
-- Instructors can view term students if they own the term
CREATE POLICY "Instructors can view own term students"
  ON term_students
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM terms
      WHERE terms.id = term_students.term_id
      AND terms.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can create own term students"
  ON term_students
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM terms
      WHERE terms.id = term_students.term_id
      AND terms.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can update own term students"
  ON term_students
  FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM terms
      WHERE terms.id = term_students.term_id
      AND terms.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can delete own term students"
  ON term_students
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM terms
      WHERE terms.id = term_students.term_id
      AND terms.instructor_id = auth.uid()
    )
  );
