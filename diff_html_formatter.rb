# frozen_string_literal: true

require 'diff/lcs'

# DiffHTMLFormatterクラスは、2つの文字列間の違いをHTML表現で生成します。
# このクラスは、Longest Common Subsequence (LCS) アルゴリズムを使用して
# 類似点を識別します。違いは赤（最初の文字列からの削除）と 緑でハイライトされます（2番目の文字列からの追加）。
class DiffHTMLFormatter
  def initialize(original, modified)
    @orig = original
    @mod = modified
  end

  def to_html
    formatted_diff.join
  end

  private

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
