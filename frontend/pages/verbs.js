import NavBar from "../components/navbar"
import VerbsSession from "../components/verbsSession"

function Verbs() {

    const topics = [[{ name: "-are", id: 1 }, { name: "-ere", id: 2 }, { name: "-ire", id: 3 }], 5]

    return (
        <div className="verbs" >
            <NavBar></NavBar>
            <div>
                <h4 style={{
                    display: 'flex',
                    justifyContent: 'center'
                }}>Verbs Practice</h4>
                <br></br>
                <VerbsSession topics={topics}></VerbsSession>
            </div>
        </div>
    )
}

export default Verbs