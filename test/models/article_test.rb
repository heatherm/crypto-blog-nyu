require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Article.new
    assert_not article.save
  end
  test "should not save article without body over 10 characters" do
    article = Article.new(title: "foo", body: "123456789")
    assert_not article.save
  end
  test "should save a valid article" do
    article = Article.new(title: "foo", body: "1234567890")
    assert article.save
  end
end
