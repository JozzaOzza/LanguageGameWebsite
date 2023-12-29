import NavBar from "../components/navbar"
import VerbsSession from "../components/verbsSession"

function Verbs() {

    const topics = [[{ name: "-are", id: 1 }, { name: "-ere", id: 2 }, { name: "-ire", id: 3 }], "verbs"]

    return (
        <div className="verbs" >
            <NavBar></NavBar>
            <div>
                <VerbsSession topics={topics}></VerbsSession>
            </div>
        </div>
    )
}

export default Verbs