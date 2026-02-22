# frozen_string_literal: true
# rbs_inline: enabled

require 'google/cloud/ai_platform/v1'

class AIPlatformSample
  #: () -> Google::Cloud::AIPlatform::V1::PredictionService::Client
  def create_client
    Google::Cloud::AIPlatform::V1::PredictionService::Client.new
  end

  #: () -> Google::Cloud::AIPlatform::V1::PredictionService::Client
  def create_client_with_config
    Google::Cloud::AIPlatform::V1::PredictionService::Client.new do |config|
      config.endpoint = 'aiplatform.googleapis.com'
      config.timeout = 30.0
    end
  end

  #: (Google::Cloud::AIPlatform::V1::PredictionService::Client, ::String, ::String) -> Google::Cloud::AIPlatform::V1::GenerateContentResponse
  def generate_content(client, model, prompt)
    client.generate_content({
      model: model,
      contents: [{ role: 'USER', parts: [{ text: prompt }] }]
    })
  end

  #: (Google::Cloud::AIPlatform::V1::GenerateContentResponse) -> ::Array[Google::Cloud::AIPlatform::V1::Candidate]
  def get_candidates(response)
    response.candidates
  end

  #: (Google::Cloud::AIPlatform::V1::Candidate) -> Google::Cloud::AIPlatform::V1::Content?
  def get_content(candidate)
    candidate.content
  end

  #: (Google::Cloud::AIPlatform::V1::Content) -> ::Array[Google::Cloud::AIPlatform::V1::Part]
  def get_parts(content)
    content.parts
  end

  #: (Google::Cloud::AIPlatform::V1::Part) -> ::String
  def get_text(part)
    part.text
  end
end

# PredictionService::Client
client = Google::Cloud::AIPlatform::V1::PredictionService::Client.new

# with block
client2 = Google::Cloud::AIPlatform::V1::PredictionService::Client.new do |config|
  config.endpoint = 'aiplatform.googleapis.com'
  config.timeout = 30.0
end

# generate_content with Hash
response = client.generate_content({
  model: 'projects/my-project/locations/us-central1/publishers/google/models/gemini-pro',
  contents: [{ role: 'USER', parts: [{ text: 'Hello' }] }],
  generation_config: { temperature: 0.7, max_output_tokens: 1024 }
})

# candidates
candidates = response.candidates

# content and parts
texts = candidates.filter_map(&:content).flat_map(&:parts).map(&:text)

# Candidate
candidate = candidates.first
if candidate
  content = candidate.content
  finish_reason = candidate.finish_reason

  # Content
  if content
    role = content.role
    parts = content.parts

    # Part
    part = parts.first
    text = part.text if part
  end
end
