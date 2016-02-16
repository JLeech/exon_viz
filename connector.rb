require_relative "exon.rb"
require_relative "gene.rb"

class Connector

	attr_accessor :genes
	attr_accessor :match_persent

	def initialize(genes)
		@genes = genes
	end

	def make_connections(match_persent)
		@genes.each_with_index do |gene, org_index|
			process_genes(gene,@genes[org_index+1], match_persent) unless org_index == (@genes.length - 1)
		end	
	end

	def process_genes(top,down,match_persent)
		top.exons.each_with_index do |top_exon|
			down.exons.each_with_index do |down_exon|
				if top_exon.include?(down_exon,match_persent)
					top_exon.childs << down_exon
					down_exon.parents << top_exon
				end
			end
		end
	end

end