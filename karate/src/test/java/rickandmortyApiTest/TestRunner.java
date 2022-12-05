package rickandmortyApiTest;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

class TestRunner {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:rickandmortyApiTest")
                .tags("@RickandMorty")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
