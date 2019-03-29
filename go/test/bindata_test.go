package test

import (
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestBindata(t *testing.T) {
	assert.Equal(t, "you can't take the sky from me", strings.TrimSpace(MustAssetString("go/test/test.txt")))
}
