# frozen_string_literal: true

# This controller will be used to manage the common content
class PagesController < ApplicationController
  def about; end

  def api_doc
    @api_doc_custom_view = true
  end
end
