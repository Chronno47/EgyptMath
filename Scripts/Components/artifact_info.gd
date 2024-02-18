extends Node

#dicionario de todos os artefatos no jogo
var artifacts = {
	"Gize_Artifact":false,
	"Isis_Artifact":false,
	"Sokek_Artifact":false,
	"Amonra_Artifact":false
}

func player_collected_artifact(artifact_name:String):
	if artifact_name in artifacts:
		artifacts[artifact_name] = true

func check_artifacts() -> bool:
	#i vai ser o indice que vai checar cada artefato 1 por 1
	for i in artifacts.values():
		#se o indice parar em um artefato que nao seja true, ele diz que o player nao tem todos os artefatos
		if !i:
			return false
	return true
