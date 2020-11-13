package gomock

import (
	"github.com/stretchr/testify/assert"
	"testing"

	"github.com/golang/mock/gomock"

	mocks "github.com/thought-machine/pleasings/go/test/gomock/foo/mock"
)

func TestFoo(t *testing.T) {
	ctl := gomock.NewController(t)
	defer ctl.Finish()
	fooMock := mocks.NewMockFoo(ctl)

	fooMock.EXPECT().Foo().Return("Foo")

	assert.Equal(t, "Foo", fooMock.Foo())

}