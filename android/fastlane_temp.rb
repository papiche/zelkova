default_platform(:android)

platform :android do
  lane :deploy_production_upload_test do
    upload_to_play_store(
      track: "production",
      aab: "../build/app/outputs/bundle/release/app-release.aab",
      release_status: "completed",
      skip_upload_metadata: true,
      skip_upload_images: true,
      skip_upload_screenshots: true,
      ack_bundle_installation_warning: true
    )
  end
end
