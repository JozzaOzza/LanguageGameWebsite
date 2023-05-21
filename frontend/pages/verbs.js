import NavBar from "../components/navbar"
import Session from "../components/session"

function Verbs() {
    return (
        <div className="verbs">
            <NavBar></NavBar>
            <h2>Verbs Practice</h2>

            <ul>
                <li>
                    <button>Most Common</button>
                </li>
                <li>
                    <button>Ending in -are</button>
                </li>
                <li>
                    <button>Ending in -ere, -urre, -orre, -arre</button>
                </li>
                <li>
                    <button>Ending in -ire</button>
                </li>
            </ul>
            <br></br>
            <Session></Session>
        </div>
    )
}

export default Verbs