package build.please.kotlin.test

import kotlin.test.assertEquals
import org.junit.Test as test

class TestAnswers() {
    @test fun whatIsTheAnswerToLifeTheUniverseAndEverything() {
        assertEquals(42, questions["What do you get if you multiply six by seven"]);
    }

    @test fun thereHasAlwaysBeenSomethingWrongWithTheUniverse() {
        assertEquals(42, questions["What do you get if you multiply six by nine"]);
    }
}
