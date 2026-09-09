-- Class Lessons table (stores planned and actual lessons)
CREATE TABLE class_lessons (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  class_id UUID NOT NULL REFERENCES classes(id) ON DELETE CASCADE,
  lesson_type TEXT NOT NULL CHECK (lesson_type IN ('planned', 'actual')),
  lesson_objective TEXT,
  homework TEXT,
  instructor_notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

  -- Ensure only one planned and one actual lesson per class
  UNIQUE(class_id, lesson_type)
);

-- Enable RLS
ALTER TABLE class_lessons ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON class_lessons
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Create indexes
CREATE INDEX idx_class_lessons_class ON class_lessons(class_id);
CREATE INDEX idx_class_lessons_type ON class_lessons(lesson_type);

-- RLS Policies
CREATE POLICY "Instructors can view own class lessons"
  ON class_lessons
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM classes
      WHERE classes.id = class_lessons.class_id
      AND classes.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can create own class lessons"
  ON class_lessons
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM classes
      WHERE classes.id = class_lessons.class_id
      AND classes.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can update own class lessons"
  ON class_lessons
  FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM classes
      WHERE classes.id = class_lessons.class_id
      AND classes.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can delete own class lessons"
  ON class_lessons
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM classes
      WHERE classes.id = class_lessons.class_id
      AND classes.instructor_id = auth.uid()
    )
  );
