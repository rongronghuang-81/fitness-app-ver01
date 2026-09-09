-- Terms table
CREATE TABLE terms (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  instructor_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  level_id UUID REFERENCES levels(id) ON DELETE SET NULL,
  start_date DATE NOT NULL,
  weekday INT NOT NULL CHECK (weekday >= 0 AND weekday <= 6), -- 0 = Sunday, 6 = Saturday
  start_time TIME NOT NULL,
  duration_minutes INT NOT NULL DEFAULT 60,
  number_of_weeks INT NOT NULL CHECK (number_of_weeks > 0),
  location TEXT,
  status TEXT NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'active', 'completed', 'cancelled')),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE terms ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON terms
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Create indexes
CREATE INDEX idx_terms_instructor ON terms(instructor_id);
CREATE INDEX idx_terms_status ON terms(status);
CREATE INDEX idx_terms_start_date ON terms(start_date);

-- RLS Policies
CREATE POLICY "Instructors can view own terms"
  ON terms
  FOR SELECT
  USING (auth.uid() = instructor_id);

CREATE POLICY "Instructors can create own terms"
  ON terms
  FOR INSERT
  WITH CHECK (auth.uid() = instructor_id);

CREATE POLICY "Instructors can update own terms"
  ON terms
  FOR UPDATE
  USING (auth.uid() = instructor_id);

CREATE POLICY "Instructors can delete own terms"
  ON terms
  FOR DELETE
  USING (auth.uid() = instructor_id);
