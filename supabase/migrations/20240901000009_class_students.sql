-- Class Students table (attendance and per-student class records)
CREATE TABLE class_students (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  class_id UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  attendance_status TEXT CHECK (attendance_status IN ('present', 'absent', 'late', 'excused')),
  performance_notes TEXT,
  achievements TEXT,
  difficulties TEXT,
  homework TEXT,
  instructor_notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Ensure a student can only have one record per class
  UNIQUE(class_id, student_id)
);

-- Enable RLS
ALTER TABLE class_students ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON class_students
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Create indexes
CREATE INDEX idx_class_students_class ON class_students(class_id);
CREATE INDEX idx_class_students_student ON class_students(student_id);
CREATE INDEX idx_class_students_attendance ON class_students(attendance_status);

-- RLS Policies
CREATE POLICY "Instructors can view own class students"
  ON class_students
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM classes
      WHERE classes.id = class_students.class_id
      AND classes.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can create own class students"
  ON class_students
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM classes
      WHERE classes.id = class_students.class_id
      AND classes.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can update own class students"
  ON class_students
  FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM classes
      WHERE classes.id = class_students.class_id
      AND classes.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can delete own class students"
  ON class_students
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM classes
      WHERE classes.id = class_students.class_id
      AND classes.instructor_id = auth.uid()
    )
  );
