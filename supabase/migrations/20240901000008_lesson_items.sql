-- Lesson Items table (structured lesson sections)
-- Phase 1: Free text only
-- Phase 2: Will link to tricks and exercises
CREATE TABLE lesson_items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  lesson_id UUID NOT NULL REFERENCES class_lessons(id) ON DELETE CASCADE,
  section TEXT NOT NULL CHECK (section IN ('warmup', 'conditioning', 'preparation', 'tricks', 'combinations', 'cooldown')),
  item_type TEXT NOT NULL DEFAULT 'free_text' CHECK (item_type IN ('trick', 'exercise', 'free_text')),
  trick_id UUID, -- Will be linked in Phase 2
  exercise_id UUID, -- Will be linked in Phase 2
  free_text TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  duration_minutes INT,
  sets INT,
  reps TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE lesson_items ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON lesson_items
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Create indexes
CREATE INDEX idx_lesson_items_lesson ON lesson_items(lesson_id);
CREATE INDEX idx_lesson_items_section ON lesson_items(section);
CREATE INDEX idx_lesson_items_sort ON lesson_items(sort_order);

-- RLS Policies
CREATE POLICY "Instructors can view own lesson items"
  ON lesson_items
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM class_lessons cl
      JOIN classes c ON c.id = cl.class_id
      WHERE cl.id = lesson_items.lesson_id
      AND c.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can create own lesson items"
  ON lesson_items
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM class_lessons cl
      JOIN classes c ON c.id = cl.class_id
      WHERE cl.id = lesson_items.lesson_id
      AND c.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can update own lesson items"
  ON lesson_items
  FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM class_lessons cl
      JOIN classes c ON c.id = cl.class_id
      WHERE cl.id = lesson_items.lesson_id
      AND c.instructor_id = auth.uid()
    )
  );

CREATE POLICY "Instructors can delete own lesson items"
  ON lesson_items
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM class_lessons cl
      JOIN classes c ON c.id = cl.class_id
      WHERE cl.id = lesson_items.lesson_id
      AND c.instructor_id = auth.uid()
    )
  );
