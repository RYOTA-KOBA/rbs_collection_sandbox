require "google/cloud/ai_platform/v1"

# PredictionService::Client
client = Google::Cloud::AIPlatform::V1::PredictionService::Client.new

# with block
client2 = Google::Cloud::AIPlatform::V1::PredictionService::Client.new do |config|
  config.endpoint = "aiplatform.googleapis.com"
  config.timeout = 30.0
end

# generate_content with Hash
response = client.generate_content({
  model: "projects/my-project/locations/us-central1/publishers/google/models/gemini-pro",
  contents: [{ role: "USER", parts: [{ text: "Hello" }] }],
  generation_config: { temperature: 0.7, max_output_tokens: 1024 }
})

# candidates
candidates = response.candidates

# content and parts
texts = candidates.map(&:content).flat_map(&:parts).map(&:text)

# Candidate
candidate = candidates.first
if candidate
  content = candidate.content
  finish_reason = candidate.finish_reason

  # Content
  role = content.role
  parts = content.parts

  # Part
  part = parts.first
  if part
    text = part.text
  end
end
