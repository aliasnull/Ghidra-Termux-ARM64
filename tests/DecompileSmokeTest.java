import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileResults;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionIterator;
import ghidra.util.task.ConsoleTaskMonitor;

public class DecompileSmokeTest extends GhidraScript {
    @Override
    public void run() throws Exception {
        DecompInterface decompiler = new DecompInterface();

        try {
            if (!decompiler.openProgram(currentProgram)) {
                throw new Exception("Failed to open program in decompiler.");
            }

            FunctionIterator functions =
                currentProgram.getFunctionManager().getFunctions(true);

            if (!functions.hasNext()) {
                throw new Exception("No functions found to decompile.");
            }

            Function function = functions.next();
            DecompileResults result =
                decompiler.decompileFunction(function, 60, new ConsoleTaskMonitor());

            if (result == null || !result.decompileCompleted()
                    || result.getDecompiledFunction() == null) {
                throw new Exception("Decompilation failed: "
                    + (result == null ? "No result returned." : result.getErrorMessage()));
            }

            println("DECOMPILE_SMOKE_TEST=PASS");
            println("FUNCTION: " + function.getName());
            println(result.getDecompiledFunction().getC());
        } finally {
            decompiler.dispose();
        }
    }
}
