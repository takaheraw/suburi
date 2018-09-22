Paperclip.options[:read_timeout] = 60

Paperclip.interpolates :filename do |attachment, style|
  return attachment.original_filename if style == :original
  [basename(attachment, style), extension(attachment, style)].delete_if(&:blank?).join('.')
end

Paperclip::Attachment.default_options.merge!(
  use_timestamp: false,
  path: ':class/:attachment/:id_partition/:style/:filename',
  storage: :fog
)

Paperclip::Attachment.default_options.merge!(
  storage: :filesystem,
  use_timestamp: true,
  path: (ENV['PAPERCLIP_ROOT_PATH'] || ':rails_root/public/system') + '/:class/:attachment/:id_partition/:style/:filename',
  url: (ENV['PAPERCLIP_ROOT_URL'] || '/system') + '/:class/:attachment/:id_partition/:style/:filename',
)
