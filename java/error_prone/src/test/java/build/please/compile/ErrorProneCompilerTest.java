package build.please.compile;

import build.please.worker.WorkerProto.BuildRequest;
import org.junit.Test;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;


public class ErrorProneCompilerTest {
    @Test
    public void testContainsDefault() {
        assertTrue(ErrorProneCompiler.shouldCheck(BuildRequest.newBuilder().build()));
    }

    @Test
    public void testContainsProto() {
        assertFalse(ErrorProneCompiler.shouldCheck(BuildRequest.newBuilder()
                                                   .addLabels("proto")
                                                   .build()));
    }
}
