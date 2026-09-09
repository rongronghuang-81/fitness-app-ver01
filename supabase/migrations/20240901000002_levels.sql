-- Levels table (Beginner, Intermediate, Advanced, etc.)
CREATE TABLE levels (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  instructor_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  sort_order INT NOT NULL DEFAULT 0,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE levels ENABLE ROW LEVEL SECURITY;

-- Create updated_at trigger
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON levels
FOR EACH ROW
EXECUTE FUNCTION trigger_set_timestamp();

-- Create index
CREATE INDEX idx_levels_instructor ON levels(instructor_id);
CREATE INDEX idx_levels_active ON levels(active);

-- RLS Policies
CREATE POLICY "Instructors can view own levels"
  ON levels
  FOR SELECT
  USING (auth.uid() = instructor_id);

CREATE POLICY "Instructors can create own levels"
  ON levels
  FOR INSERT
  WITH CHECK (auth.uid() = instructor_id);

CREATE POLICY "Instructors can update own levels"
  ON levels
  FOR UPDATE
  USING (auth.uid() = instructor_id);

CREATE POLICY "Instructors can delete own levels"
  ON levels
  FOR DELETE
  USING (auth.uid() = instructor_id);
