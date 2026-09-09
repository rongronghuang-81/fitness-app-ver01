-- Classes table
CREATE TABLE classes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  term_id UUID NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
  instructor_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  week_number INT NOT NULL,
  scheduled_date DATE NOT NULL,
  start_time TIME NOT NULL,
  duration_minutes INT NOT NULL DEFAULT 60,
  status TEXT NOT NULL DEFAULT 'planned' CHECK (status IN ('planned', 'completed', 'cancelled', 'rescheduled')),
  theme TEXT,
  general_notes TEXT,
  completed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE classes ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON classes
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Create indexes
CREATE INDEX idx_classes_term ON classes(term_id);
CREATE INDEX idx_classes_instructor ON classes(instructor_id);
CREATE INDEX idx_classes_scheduled_date ON classes(scheduled_date);
CREATE INDEX idx_classes_status ON classes(status);

-- RLS Policies
CREATE POLICY "Instructors can view own classes"
  ON classes
  FOR SELECT
  USING (auth.uid() = instructor_id);

CREATE POLICY "Instructors can create own classes"
  ON classes
  FOR INSERT
  WITH CHECK (auth.uid() = instructor_id);

CREATE POLICY "Instructors can update own classes"
  ON classes
  FOR UPDATE
  USING (auth.uid() = instructor_id);

CREATE POLICY "Instructors can delete own classes"
  ON classes
  FOR DELETE
  USING (auth.uid() = instructor_id);
