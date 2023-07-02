import NavBar from "../components/navbar"
import Session from "../components/session"

function Verbs() {

    const topics = [[{ name: "-are", id: 1 }, { name: "-ere", id: 2 }, { name: "-ire", id: 3 }], 5]

    return (
        <div className="verbs" >
            <NavBar></NavBar>
            <div>
                <h4>Verbs Practice</h4>
                <br></br>
                <Session topics={topics}></Session>
            </div>
        </div>
    )
}

export default Verbs