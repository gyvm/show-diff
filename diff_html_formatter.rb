require 'diff/lcs'

class DiffHTMLFormatter
  def initialize(a, b)
    @a = a
    @b = b
  end

  def to_html
    formatted_diff.join
  end

  private

  def formatted_diff
    lcs = Diff::LCS.lcs(@a, @b)
    b_diff = []

    ai = bi = 0

    lcs.each do |lcs_char|
      while @a[ai] != lcs_char
        b_diff << "<span style='color: red; text-decoration: line-through;'>#{@a[ai]}</span>"
        ai += 1
      end

      while @b[bi] != lcs_char
        b_diff << "<span style='color: green;'>#{@b[bi]}</span>"
        bi += 1
      end

      b_diff << @b[bi]
      ai += 1
      bi += 1
    end

    while ai < @a.size
      b_diff << "<span style='color: red; text-decoration: line-through;'>#{@a[ai]}</span>"
      ai += 1
    end

    while bi < @b.size
      b_diff << "<span style='color: green;'>#{@b[bi]}</span>"
      bi += 1
    end

    b_diff
  end
end
