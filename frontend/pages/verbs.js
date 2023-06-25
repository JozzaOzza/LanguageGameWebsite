import NavBar from "../components/navbar"
import Session from "../components/session"

function Verbs() {

    const topics = [[{name: "-are", id: 1}, {name: "-ere", id: 2}, {name: "-ire", id: 3}], 5]

    return (
        <div className="verbs">
            <NavBar></NavBar>
            <h2>Verbs Practice</h2>
            <br></br>
            <Session topics={topics}></Session>
        </div>
    )
}

export default Verbs