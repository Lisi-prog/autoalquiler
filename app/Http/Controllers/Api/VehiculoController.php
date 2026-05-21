namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;

class VehiculoController extends Controller
{
    public function index()
    {
        $vehiculos = DB::select("
            SELECT *
            FROM listar_vehiculos()
        ");

        return response()->json($vehiculos);
    }
}