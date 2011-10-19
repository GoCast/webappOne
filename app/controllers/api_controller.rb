require 'net/http'

class ApiController < ApplicationController
  
  def call
    @method = params[:method]
    @prefix = "http://localhost:8081"
    
    @url = "#{@prefix}/#{routes[@method]}"

    @uri = URI.parse(@url)
    
    @response = Net::HTTP.start(@uri.host, @uri.port) {|http|
      http.get "#{@uri.path}#{clean_params}"
    }.body
    
    render :json => eval(@response), :content_type => "application/json" 
  end

  def routes
		{
      "capture"       => "GET_CAPTURE_STATE",
      "capture/start" => "START_CAPTURE",
      "capture/stop"  => "STOP_CAPTURE",
      "capture/url"   => "GET_RTSP_URL",

      "volume"        => "GET_MIC_VOLUME",
      "volume/set"    => "SET_MIC_VOLUME",
      "volume/toggle" => "SET_MIC_TOGGLE_MUTE",

      "bitrate"       => "GET_BITRATE",
      "bitrate/set"   => "SET_BITRATE",

      "framerate"     => "GET_FRAMERATE",
      "framerate/set" => "SET_FRAMERATE",

      "resolution"    => "GET_RESOLUTION"
    }
  end

  def clean_params
		clean_params = params
    clean_params.delete "controller"
    clean_params.delete "action"
    clean_params.delete "method"
    "?" + clean_params.map{|k,v|"#{k}=#{v}"}.join("&") unless clean_params.empty?
  end

end
