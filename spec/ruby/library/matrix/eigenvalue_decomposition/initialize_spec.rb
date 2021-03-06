require File.expand_path('../../../../spec_helper', __FILE__)
require 'matrix'

ruby_version_is "1.9.3" do
  describe "Matrix::EigenvalueDecomposition#initialize" do
    it "raises an error if argument is not a matrix" do
      lambda {
        Matrix::EigenvalueDecomposition.new([[]])
      }.should raise_error(TypeError)
      lambda {
        Matrix::EigenvalueDecomposition.new(42)
      }.should raise_error(TypeError)
    end

    it "raises an error if matrix is not square" do
      lambda {
        Matrix::EigenvalueDecomposition.new(Matrix[[1, 2]])
      }.should raise_error(Matrix::ErrDimensionMismatch)
    end

    ruby_bug "Fixed in Jama 1.0.3", "1.9.3" do
      it "never hangs" do
        m = Matrix[ [0,0,0,0,0], [0,0,0,0,1], [0,0,0,1,0], [1,1,0,0,1], [1,0,1,0,1] ]
        Matrix::EigenvalueDecomposition.new(m).should_not == "infinite loop"
      end
    end
  end
end
