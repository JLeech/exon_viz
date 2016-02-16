require_relative "gene.rb"

class Statistic

	attr_accessor :genes

	def initialize(genes)
		@genes = genes
	end

	def intersections
		intersections_length = []
		@genes.each_with_index do |gene,index|
			break if index == (@genes.length - 1)
			gene.exons.each do |exon|
				@genes[index+1].exons.each do |down_exon|
					size = exon.intersection_length(down_exon)
					intersections_length << ((exon.start..exon.finish).size - size) + ((down_exon.start..down_exon.finish).size - size)  unless size == 0
				end
			end
		end
		intersections_length.sort!
		lengths = Hash.new { |hash, key| hash[key] = 0 }
		intersections_length.each do |value|
			lengths[value] += 1
		end
		length = lengths.sort_by{|k,v| v }.to_h
		sorted_by_value = "("
		length.keys.each do |key|
			sorted_by_value += "#{key},"
		end
		sorted_by_value += ")\n"
		sorted_by_value += "("
		length.keys.each do |key|
			sorted_by_value += "\"#{length[key]}\","
		end
		sorted_by_value += ")\n"
		File.write("intersection_stat.txt",sorted_by_value)
	end

	def intersections_percent
		intersections_length = []
		@genes.each_with_index do |gene,index|
			break if index == (@genes.length - 1)
			gene.exons.each do |exon|
				@genes[index+1].exons.each do |down_exon|
					size = exon.intersection_length(down_exon)
					min_exon = [(exon.start..exon.finish).size,(down_exon.start..down_exon.finish).size].min
					intersections_length << (size.to_f/min_exon.to_f).round(2) unless (size == 0 || min_exon == 0 ) 
				end
			end
		end
		intersections_length.sort!
		lengths = Hash.new { |hash, key| hash[key] = 0 }
		intersections_length.each do |value|
			lengths[value] += 1
		end
			print_sorted_by_value(lengths,"intersection_stat_percent.txt")
	end

	def print_sorted_by_value(hash,file)
		hash = hash.sort_by{|k,v| v }.to_h
		sorted_by_value = "("
		hash.keys.each do |key|
			sorted_by_value += "#{key},"
		end
		sorted_by_value += ")\n"
		sorted_by_value += "("
		hash.keys.each do |key|
			sorted_by_value += "\"#{hash[key]}\","
		end
		sorted_by_value += ")\n"
		File.write(file,sorted_by_value)
	end

	def count_root_exons
		up_down_routes = []
		@genes.each do |gene|
			gene.exons.each do |exon|
				exon.childs.each 
			end
		end
	end
end