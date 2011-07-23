# Be sure to restart your server when you modify this file.
module I18n

      def self.name_for_locale(locale)
        begin
          I18n.backend.translate(locale, "meta.language_name")
        rescue I18n::MissingTranslationData
          locale.to_s
        end
      end

end

