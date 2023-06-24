import NavBar from "../components/navbar"
import Session from "../components/session"

function Verbs() {

    const topics = [[{name: "jamie", id: 1}, {name: "orr", id: 2}], 5]

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