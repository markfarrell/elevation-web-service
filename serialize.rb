#!/usr/bin/env ruby

require 'digest/md5'
require 'rdf'
require 'rdf/ntriples'
require 'rdf/n3'
require 'rdf/raptor'

md5 = Digest::MD5.new

ARGF.each_line { |line|

  geo_long, geo_lat, geo_alt = line.split(" ")

  geo_point_uri = RDF::URI("http://www.w3.org/2003/01/geo/wgs84_pos#Point")
  geo_long_uri = RDF::URI("http://www.w3.org/2003/01/geo/wgs84_pos#long")
  geo_lat_uri  = RDF::URI("http://www.w3.org/2003/01/geo/wgs84_pos#lat")
  geo_alt_uri  = RDF::URI("http://www.w3.org/2003/01/geo/wgs84_pos#alt")

  output = RDF::Writer.for(:n3).buffer do |writer|
    md5 << "%geo_long_url %geo_lat_url %geo_alt_uri"
    subject = RDF::Node.new(md5.hexdigest)
    writer << [subject, RDF.type, geo_point_uri]
    writer << [subject, geo_long_uri, geo_long]
    writer << [subject, geo_lat_uri, geo_lat]
    writer << [subject, geo_alt_uri, geo_alt]
  end

  $stdout.write output

}
